require 'open-uri'
require 'nokogiri'

class Ad < ApplicationRecord
  validates :specialty, presence: true
  validates :target_url, presence: true
  validates :position, inclusion: { in: %w[left right] }

  after_initialize :set_default_position, if: :new_record?
  after_create :fetch_og_data, if: -> { target_url.present? }
  after_initialize :set_default_values, if: :new_record?

  def set_default_position
    self.position ||= 'right'
  end

  def set_default_values
    self.page_clicks ||= {} # Ensure it's always an empty hash if not set
    self.user_clicks ||= {} # Ensure it's always an empty hash if not set
  end

  def track_click(user_id, page)
    # Increment total clicks
    increment!(:clicks)

    # Track page clicks
    self.page_clicks[page] ||= 0
    self.page_clicks[page] += 1

    # Track user clicks (indexed by user_id)
    self.user_clicks[user_id.to_s] ||= 0
    self.user_clicks[user_id.to_s] += 1

    # Update last clicked timestamp
    self.last_clicked_at = Time.current

    # Save the ad after making updates
    save
  end

  private

  def fetch_og_data
    begin
      uri = URI.parse(target_url)
      html = uri.open(
        read_timeout: 10,
        ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,
        "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
      ).read
      doc = Nokogiri::HTML(html)

      # Try to fetch image from various sources in order of preference
      image_url = find_image(doc)
      title = find_title(doc)
      description = find_description(doc)

      # If we couldn't find essential data, raise an error
      if image_url.nil? || title.nil? || description.nil?
        raise "Failed to fetch necessary metadata from #{target_url}"
      end

      # Store the fetched data
      self.image_url = image_url
      self.title = title
      self.content = description
      
      save! # Ensure the ad is only saved if everything was fetched successfully

    rescue => e
      # Log the error message
      Rails.logger.error("Error fetching metadata for #{target_url}: #{e.message}")

      # Optionally, return a validation error if you want to prevent the ad from being created
      errors.add(:base, "Ad could not be created. Error: #{e.message}")
      raise ActiveRecord::Rollback # Rollback the transaction if the data is incomplete or invalid
    end
  end

  def find_image(doc)
    # Try various image sources in order of preference
    image_sources = [
      'meta[property="og:image"]',
      'meta[name="twitter:image"]',
      'meta[property="twitter:image"]',
      'meta[name="image"]',
      'meta[property="image"]',
      'link[rel="image_src"]',
      'meta[itemprop="image"]'
    ]

    image_sources.each do |selector|
      element = doc.at(selector)
      return element['content'] if element && element['content'].present?
    end

    # If no meta image found, try to find the largest image on the page
    largest_image = doc.css('img').max_by { |img| 
      width = img['width'].to_i
      height = img['height'].to_i
      width * height
    }
    
    largest_image['src'] if largest_image && largest_image['src'].present?
  end

  def find_title(doc)
    # Try various title sources in order of preference
    title_sources = [
      'meta[property="og:title"]',
      'meta[name="twitter:title"]',
      'meta[property="twitter:title"]',
      'title',
      'meta[name="title"]',
      'meta[property="title"]',
      'h1'
    ]

    title_sources.each do |selector|
      element = doc.at(selector)
      return element['content'] if element && element['content'].present?
      return element.text if element && element.text.present?
    end

    nil
  end

  def find_description(doc)
    # Try various description sources in order of preference
    description_sources = [
      'meta[property="og:description"]',
      'meta[name="twitter:description"]',
      'meta[property="twitter:description"]',
      'meta[name="description"]',
      'meta[property="description"]',
      'meta[itemprop="description"]'
    ]

    description_sources.each do |selector|
      element = doc.at(selector)
      return element['content'] if element && element['content'].present?
    end

    # If no meta description found, try to get the first paragraph
    first_paragraph = doc.at('p')
    first_paragraph.text if first_paragraph && first_paragraph.text.present?
  end
end


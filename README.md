# 🩺 Doximity Clone – Full-Stack Healthcare Networking Platform

A robust, scalable web application inspired by Doximity
, designed to connect healthcare professionals and streamline their digital workflows. Built with Ruby on Rails 8.0 and modern web technologies.

# 🚀 Overview

  The platform enables verified medical professionals to network, communicate, and manage appointments securely in a digital environment. It integrates real-time messaging, professional profiles, geolocation features, and smart advertising into a cohesive experience.

# 🧩 Key Features

  👥 Professional Networking

  User connection system with request/accept flow
  
  Specialty-based suggestions for smarter recommendations

💬 Real-Time Communication

Real-time chat powered by SolidCable and WebSockets

📰 Content Management

Infinite-scroll news feed

Post creation, comments, and reactions

📅 Appointment Scheduling

Calendar system for availability management

Time-slot booking and confirmation

🎯 Smart Advertising

Targeted ads based on specialties

Click tracking and performance analytics

📍 Geolocation Features

Integrated geocoding for user discovery

Map-based professional search

🔔 Notification System

Alerts for new messages, connection updates, and bookings

👤 User Profiles

Customizable profiles with photo uploads

Detailed professional bios and credentials

# 🛠️ Tech Stack

Layer	Technologies

Backend	Ruby on Rails 8.0, PostgreSQL, SolidCache

Frontend	Tailwind CSS, Turbo Streams, StimulusJS

Auth & Storage	Devise (authentication), ActiveStorage (image uploads)

Deployment	Docker + Kamal

Development Tools	Rubocop, Brakeman, Letter Opener

Performance	Pagy for pagination, optimized queries, caching strategies

Security	CSRF protection, secure session management, CI with test coverage

# ⚙️ Installation & Setup (Optional Section)

# Clone the repository
    git clone https://github.com/yourusername/doximity-clone.git
    
    cd doximity-clone

# Install dependencies
    bundle install  
    
    yarn install

# Setup the database
`rails db:create db:migrate db:seed`

# Start the server
`bin/dev`


Then open http://localhost:3000 to explore the platform.

🧪 Development Highlights

Built in a modular, service-oriented structure for scalability

Uses SolidCable and Turbo Streams for real-time UI updates

Implements Rubocop, Brakeman, and automated tests for code quality

Dockerized with Kamal for consistent deployment

# 🧠 Learning Goals

This project demonstrates:

Scalable architecture in Rails 8.0

Real-time data handling with WebSockets

Secure authentication and session management

Advanced caching and performance optimization

Integration of modern frontend with Hotwire stack

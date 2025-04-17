import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["calendar"]

  connect() {
    console.log('Calendar controller connected')
    this.initializeCalendar()
  }

  async initializeCalendar() {
    console.log('Initializing calendar...')
    
    // Wait for FullCalendar to be loaded
    if (!window.FullCalendar) {
      console.log('FullCalendar not loaded yet, waiting...')
      await new Promise(resolve => {
        const checkFullCalendar = setInterval(() => {
          if (window.FullCalendar) {
            clearInterval(checkFullCalendar)
            resolve()
          }
        }, 100)
      })
    }
    
    const calendarEl = this.calendarTarget
    if (!calendarEl) {
      console.error('Calendar element not found!')
      return
    }
    
    console.log('Calendar element found, creating FullCalendar instance...')
    
    try {
      this.calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        aspectRatio: 1.8,
        displayEventTime: false,
        allDaySlot: false,
        events: {
          url: '/calendar.json',
          method: 'GET',
          failure: function() {
            console.error('Failed to fetch time slots')
          }
        },
        eventDidMount: function(info) {
          const eventEl = info.el
          const event = info.event
          const status = event.extendedProps.status
          
          // Add status-specific classes
          if (status === 'scheduled') {
            eventEl.classList.add('scheduled-slot')
          } else if (status === 'pending') {
            eventEl.classList.add('pending-slot')
          } else {
            eventEl.classList.add('available-slot')
          }

          const startTime = event.start.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
          const endTime = event.end.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
          const displayTitle = startTime + ' - ' + endTime
          
          const titleEl = eventEl.querySelector('.fc-event-title')
          if (titleEl) {
            titleEl.textContent = displayTitle
            titleEl.classList.add('font-medium', 'text-center')
          }
        }
      })
      
      this.calendar.render()
      console.log('Calendar rendered successfully')
    } catch (error) {
      console.error('Error initializing calendar:', error)
    }
  }

  disconnect() {
    if (this.calendar) {
      this.calendar.destroy()
    }
  }
} 
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Start the timer when the controller connects
    this.startTimer()
  }

  startTimer() {
    // Set timeout to remove the element after 3 seconds
    setTimeout(() => {
      // Add fade-out animation
      this.element.classList.add('animate-fade-out')
      
      // Remove the element after animation completes
      setTimeout(() => {
        this.element.remove()
      }, 300)
    }, 3000)
  }
} 
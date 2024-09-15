import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["login-modal"];
    // static targets = [ "image", "input", "button" ]

    connect() {
        // Optional: Log to the console when the controller is loaded
        console.log("Modalaa controller connected");
    }

    open(event) {
        event.preventDefault();
        console.log(this)
        console.log(this.modalTarget)
        const modalId = event.params.test;
        console.log(modalId)

        const modalElement = document.getElementById(modalId);
        modalElement.classList.remove("hidden");
    }

    close(event) {
        event.preventDefault();
        const modalId = event.params.id;
        console.log(event.params)
        console.log(modalId)

        const modalElement = document.getElementById(modalId);
        modalElement.classList.add("hidden");
    }
}

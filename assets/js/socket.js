// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})


socket.connect()


const vacId = $("#vac_id").val()
// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("vac:images:" + vacId, {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("new_images", payload => {
  $("#new_images_message").empty();
  payload['images'].forEach(image => {
    let aElement = document.createElement("a");
    aElement.href = image.url;
    aElement.target = "_blank"
    let imageElement = document.createElement("img");
    imageElement.src = image.thumbnail_url;
    aElement.appendChild(imageElement)
    $("#masonry").append(aElement);
  });
})

export default socket

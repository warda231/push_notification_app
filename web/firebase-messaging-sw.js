importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
    apiKey: "AIzaSyD8mqBAZ2p9QRKTzOPGX2iMwsJFE_Ty6Z4",
    authDomain: "push-notification-c1bb8.firebaseapp.com",
    projectId: "push-notification-c1bb8",
    storageBucket: "push-notification-c1bb8.appspot.com",
    messagingSenderId: "781649625274",
    appId: "1:781649625274:web:890cce49470dee274f0283"
  };



firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
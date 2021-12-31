importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyDHZrRiG8pGSmJLh9DgrIaNdzVL_CrkNys",
  authDomain: "smartpond-333917.appspot.com",
  projectId: "smartpond-333917",
  storageBucket: "smartpond-333917.appspot.com",
  messagingSenderId: "250728969979",
  appId: "1:673110705551:android:23352d2a9abf7b8010f7fa",
  databaseURL: "...",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
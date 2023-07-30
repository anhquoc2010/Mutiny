const firebase = require("firebase-admin");
const http = require("http");
const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const port = 3000;

// Initialize Firebase Admin SDK
const serviceAccount = require("./serviceKeyAccount.json");
firebase.initializeApp({
    credential: firebase.credential.cert(serviceAccount),
    databaseURL: "https://greennavigator-904c2.firebaseio.com", // Replace with your Firebase database URL
});
const messaging = firebase.messaging();
const db = firebase.firestore();
const docRefRoutes = db.collection("Routes").doc();
const docRefHabits = db.collection("HabitRoutes").doc();
const weatherAPIKey = "d9a584b47da74eadad2eb1d2723a6fb5";

app.use(express.json());

app.get("/", (req, res) => {
    res.send("Hello World!");
});

var CronJob = require('cron').CronJob;
var job = new CronJob(
    '*/5 * * * *',
    function() {
        JobFunction()
    },
    null,
    true,
    'America/Los_Angeles'
);
job.start();

function notifyToUser() {
    const registrationToken = 'era-7qMbTcqFvipcQOUSOC:APA91bFRR8Sdr9RHLedPpvTJk1zj0i_xKGxoS1_SZuSB3RCImFZFNGWMUdNuO8wEBrM53HdmPlO2fYl7o2fo4KBMmw9G8NDPZpvNzStDQBx73PVhLEkg6tfyhj5oKFF73CyGIMRZgpIM';
    const message = {
        data: {
          // You can send additional data here
          // For example, you can send a custom notification payload
          title: 'New Notification',
          body: 'This is a test notification.',
          click_action: 'FLUTTER_NOTIFICATION_CLICK', // This depends on how you handle notifications on your app client-side
        },
        token: registrationToken,
    };
    firebase
        .messaging()
        .send(message)
        .then((response) => {
            console.log("Notification sent successfully:", response);
        }
        )
}
notifyToUser()

function upgradeRouteToHabitRoute(route) {
    const newId = docRefHabits.id;
    const newHabitRoute = {
        ...route,
        habitRouteId: newId,
    }
    docRefHabits.set(route);
}

function getAllRoutefromDatabase() {
    const db = firebase.firestore();
    const routes = db.collection("Routes").get();
    return routes;
}

async function checkIfRouteExistsInHabitRoute(route) {
    if (!route.habitRouteId) {
        // If habitRouteId is not defined, we cannot perform the query
        return false;
    }
    const habitRouteRef = db.collection("HabitRoutes").where("habitRouteId", "==", route.habitRouteId);
    const snapshot = await habitRouteRef.get();
    return !snapshot.empty;
  }
  
  async function JobFunction() {
    try {
      const routesRef = db.collection("Routes");
  
      const routesSnapshot = await routesRef.get();
      const currentTime = new Date();
  
      const habitRouteBatch = db.batch(); // Create a new WriteBatch for updating routes to HabitRoute
      const notificationBatch = db.batch(); // Create a new WriteBatch for sending notifications
  
      for (const routeDoc of routesSnapshot.docs) {
        const route = routeDoc.data();
  
        // Check if the route isHabit >= 3
        if (route.isHabit >= 3) {
          const existsInHabitRoute = await checkIfRouteExistsInHabitRoute(route);
          if (!existsInHabitRoute) {
            // Update route to HabitRoute
            const habitRouteRef = db.collection("HabitRoutes").doc(); // Create a new document with a generated ID
            habitRouteBatch.set(habitRouteRef, { ...route, habitRouteId: habitRouteRef.id });
          }
        }
  
        // Check if habitRoute.search_time within the next 5 minutes
        if (route.search_time && route.isHabit > 0) {
          const routeTime = new Date(route.search_time);
          const timeDifference = routeTime.getTime() - currentTime.getTime();
  
          if (timeDifference >= 0 && timeDifference <= 5 * 60 * 1000) { // 5 minutes in milliseconds
            // Notify user using Firebase FCM
            // Add your FCM notification code here
            console.log(`Notify user about HabitRoute with ID ${route.habitRouteId}`);
            
            // Update the notification status in the route document
            const routeRef = routesRef.doc(routeDoc.id);
            notificationBatch.update(routeRef, { notified: true });
          }
        }
      }
  
      // Commit the batch writes separately
      await habitRouteBatch.commit();
      await notificationBatch.commit();
  
    } catch (error) {
      console.error("Error in JobFunction:", error);
      // Handle error here
    }
  }
  
function CalculateTraficRate(duration, duration_in_traffic) {
    const trafficRate = duration_in_traffic.value / duration.value;
    if(trafficRate < 1,2) {
        return trafficRate = 1
    } else if (trafficRate >= 1,2 && trafficRate < 2) {
        return trafficRate = 2
    } else return trafficRate = 3
}

function CalculateMiddlePoint(start_location, end_location) {
    const lat1 = start_location.lat;
    const lon1 = start_location.lng;
    const lat2 = end_location.lat;
    const lon2 = end_location.lng;

    const dLon = (lon2 - lon1) * Math.PI / 180;

    //convert to radians
    lat1 = lat1 * Math.PI / 180;
    lat2 = lat2 * Math.PI / 180;
    lon1 = lon1 * Math.PI / 180;

    const Bx = Math.cos(lat2) * Math.cos(dLon);
    const By = Math.cos(lat2) * Math.sin(dLon);
    const lat3 = Math.atan2(Math.sin(lat1) + Math.sin(lat2), Math.sqrt((Math.cos(lat1) + Bx) * (Math.cos(lat1) + Bx) + By * By));
    const lon3 = lon1 + Math.atan2(By, Math.cos(lat1) + Bx);

    return {
        lat: lat3 * 180 / Math.PI,
        lng: lon3 * 180 / Math.PI
    };

}

function CalculateDistance(location1, location2) {
    const lat1 = location1.lat;
    const lon1 = location1.lng;
    const lat2 = location2.lat;
    const lon2 = location2.lng;

    const R = 6371e3; // Earth's radius in meters
    const φ1 = (lat1 * Math.PI) / 180;
    const φ2 = (lat2 * Math.PI) / 180;
    const Δφ = ((lat2 - lat1) * Math.PI) / 180;
    const Δλ = ((lon2 - lon1) * Math.PI) / 180;

    const a =
        Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
        Math.cos(φ1) * Math.cos(φ2) * Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    const distance = R * c;
    return distance;
}

// Calculate time difference in minutes between two ISO-formatted date strings
function CalculateTimeDifference(dateStr1, dateStr2) {
    const timeDiff = Math.abs(new Date(dateStr1) - new Date(dateStr2));
    return Math.floor(timeDiff / (1000 * 60));
}

function isPointInsidePolygon(x, y, polygon) {
    const n = polygon.length;
    let inside = false;
  
    let p1x = polygon[0][0];
    let p1y = polygon[0][1];
    for (let i = 0; i < n + 1; i++) {
      const [p2x, p2y] = polygon[i % n];
      if (y > Math.min(p1y, p2y)) {
        if (y <= Math.max(p1y, p2y)) {
          if (x <= Math.max(p1x, p2x)) {
            if (p1y !== p2y) {
              const xinters = (y - p1y) * (p2x - p1x) / (p2y - p1y) + p1x;
              if (p1x === p2x || x <= xinters) {
                inside = !inside;
              }
            }
          }
        }
      }
      p1x = p2x;
      p1y = p2y;
    }
  
    return inside;
  }

async function CheckRoutesisFamiliarInDatabase(routesRef, requestRoute) {
    const routesSnapshot = await routesRef.get();

    for (const routeDoc of routesSnapshot.docs) {
        const route = routeDoc.data();

        // Calculate distance between two locations
        const distance = CalculateDistance(
            requestRoute.start_location,
            route.start_location
        );

        // Calculate time difference in minutes
        const timeDiff = CalculateTimeDifference(requestRoute.search_time, route.search_time);

        // Check if the route is familiar based on the distance and time difference
        if (distance <= 3 && timeDiff <= 15) {
            // Update the existing document with increased isHabit value
            await routesRef.doc(routeDoc.id).update({ isHabit: route.isHabit + 1 });
            return true; // Route is familiar
        }
    }

    return false; // Route is not familiar
}

async function CalculateEcoFriendlyPoint(start_location, end_location, search_time, duration, duration_in_traffic) {
    const aqi = 0;
    const trafficRate = CalculateTraficRate(duration, duration_in_traffic)/3;
  
    const { lat, lng } = CalculateMiddlePoint(start_location, end_location);
    const WeatherAPI = `http://api.weatherbit.io/v2.0/forecast/hourly?lat=${lat}&lon=${lng}&key=${weatherAPIKey}`;
  
    try {
      const weatherResponse = await fetch(WeatherAPI);
      const weatherData = await weatherResponse.json();
      const api = weatherData.api/500;
  
      // get MockDaNangDistrictPolygon.json from local file
      const MockDaNangDistrictPolygon = require('./MockDanangDistrictPolygonsBoundary.json');
  
      let weatherIndistrict = 0;
  
      MockDaNangDistrictPolygon.forEach((element) => {
        if (isPointInsidePolygon(lat, lng, element.coordinates)) {
          weatherIndistrict = element.weather/100;
        }
      });

      return trafficRate + api + weatherIndistrict;
  
    } catch (error) {
      console.error("Error CalculateEcoFriendlyPoint:", error);
    }
}
  


// app.post("/api/createDocument", (req, res) => {
//     const { collection, documentId, data } = req.body;

//     if (!collection || !documentId || !data) {
//       return res.status(400).json({ error: "Invalid request body" });
//     }

//     const db = firebase.firestore();
//     const docRef = db.collection(collection).doc(documentId);

//     docRef
//       .set(data)
//       .then(() => {
//         console.log("Document created successfully");
//         res.status(200).json({ message: "Document created successfully" });
//       })
//       .catch((error) => {
//         console.error("Error creating document:", error);
//         res.status(500).json({ error: "Failed to create document" });
//       });
//   });

const mockRequestData = {
    "end_location": {
        "lat": 45.5018696,
        "lng": -73.5674191
    },
    "start_location": {
        "lat": 43.6532377,
        "lng": -79.38273819999999
    },
    search_time: "2020-11-11T00:00:00.000Z",
}

app.post("/api/saveRouteToDatabaseAndCalculateEcoFriendlyPoint", (req, res) => {
    const { start_location, end_location, search_time } = req.body;

    if (!start_location || !end_location) {
        return res.status(400).json({ error: "Invalid request body" });
    }

    if (!search_time) {
        search_time = new Date().toISOString(); // Convert to ISO format
    }

    const db = firebase.firestore();
    const routesRef = db.collection("Routes");

    CheckRoutesisFamiliarInDatabase(routesRef, req.body)
        .then((isFamiliar) => {
            if (isFamiliar) {
                res.json({ message: "Route is familiar, updated in the database" });
            } else {
                const data = {
                    start_location,
                    end_location,
                    search_time,
                    isHabit: 0,
                };
                routesRef
                    .add(data)
                    .then(() => {
                        res.json({ message: "New record created in the database" });
                    })
                    .catch((error) => {
                        console.error("Error creating document:", error);
                        res.status(500).json({ error: "Failed to create document" });
                    });
            }
        })
        .catch((error) => {
            console.error("Error checking routes in the database:", error);
            res.status(500).json({ error: "Failed at CheckRoutesisFamiliarInDatabase" });
        });
});


// Endpoint to send a notification
app.post("/sendNotification", (req, res) => {
    const { token, title, body } = req.body;

    const message = {
        notification: {
            title: title,
            body: body,
        },
        token: token,
    };

    firebase
        .messaging()
        .send(message)
        .then((response) => {
            console.log("Notification sent successfully:", response);
            res.status(200).json({ message: "Notification sent successfully" });
        })
        .catch((error) => {
            console.error("Error sending notification:", error);
            res.status(500).json({ error: "Failed to send notification" });
        });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://172.16.255.172:${port}`);
});

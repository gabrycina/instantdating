const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

var db = admin.firestore();

exports.newPokeNotification = functions.firestore
  .document("devicesLocation/{devId}/pokes/receivedCounter")
  .onWrite((change, context) => {
    var receiverId = context.params.devId;
    var userRef = db.collection("devicesLocation").doc(receiverId);
    var getUserDoc = userRef.get();
    var receivedCounterRef = userRef.collection("pokes").doc("receivedCounter");
    var getReceivedCounterDoc = receivedCounterRef.get();

    return Promise.all([getReceivedCounterDoc]).then(result => {
      var receivedCounter = result[0].data().receivedPokesLifeTimeCounter;
      if (receivedCounter !== 0) {
        return Promise.all([getUserDoc]).then(result => {
          var tokenId = result[0].data().token;

          const payload = {
            notification: {
              title: "This is a notification",
              body: "if you see this I am a genius potato",
              icon: "default"
            }
          };

          console.log(tokenId);

          return admin.messaging().sendToDevice(tokenId, payload);
        });
      }
      return console.log("User signed up");
    });
  });

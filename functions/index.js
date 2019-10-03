const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.newPokeNotification = functions.firestore
    .document('devicesLocation/{devId}/pokes/receivedCounter').onWrite((change, context) => {
        var receiverId = context.params.devId;

        var ref = admin.database().ref('devicesLocation/' + receiverId + '/token');
        return ref.once("value", function(snapshot){
            const payload = {
                notification: {
                    title: 'This is a notification',
                    body: 'if you see this I am a genius potato'
                }
            };
            
            admin.messaging().sendToDevice(snapshot.val(), payload);
        
        }, function(errorObject){
            console.log('the read failed:' + errorObject.code);
        });
    });


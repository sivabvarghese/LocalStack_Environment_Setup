/**
 * Lambda handler receives event from subscribed SNS topic
 * */
exports.handler = async (event) => {
  try {
    console.log(`Lambda received the message: ${event.Records[0].Sns.Message}`);

    // Accessing env variables passed into lambda from terraform automations
    // (In this example, an API key to communicate via HTTP with an external 3rd party service)
    console.log(`XYZ API endpoint can be accessed via access key: ${process.env.XYZ_API_ACCESS_KEY}`);
  } catch (e) {
    console.error(`Error occurred: ${e}`);
  }
};

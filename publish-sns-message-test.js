var sns = require('@aws-sdk/client-sns');

// Following should be injected from a secrets manager in a prod env
const REGION = "us-east-1";
const ENDPOINT = "http://localhost:4566"; // localstack endpoint
const ACCESS_KEY = "foobar";
const SECRET_KEY = "foobar";

const SNSClient = sns.SNSClient;
const snsClient = new SNSClient({ region: REGION, endpoint: ENDPOINT, accessKeyId: ACCESS_KEY, secretAccessKey: SECRET_KEY });

// Setup message and SNS topic
var params = {
  Message: "Test message from server to SNS topic",
  TopicArn: "arn:aws:sns:us-east-1:000000000000:test-sns-topic-dev",
};

const run = async () => {
  try {
    const data = await snsClient.send(new sns.PublishCommand(params));
    console.log("Success.",  data);
    return data; // For unit tests.
  } catch (err) {
    console.log("SNS Publish Error:", err.stack);
  }
};
run();
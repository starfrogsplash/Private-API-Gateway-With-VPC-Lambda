
import { APIGatewayProxyHandler } from 'aws-lambda';

export const handler: APIGatewayProxyHandler = async (event, context) => {
  return {
    statusCode: 200,
    body: 'Hello World'
  };
};

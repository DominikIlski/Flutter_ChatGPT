/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
import * as dotenv from 'dotenv' // see https://github.com/motdotla/dotenv#how-do-i-use-dotenv-with-import
import { Configuration, OpenAIApi } from "openai";
import {logger, https }from 'firebase-functions';
import { initializeApp } from 'firebase-admin/app';

dotenv.config()
initializeApp()

const configuration = new Configuration({
    organization: "org-1YApdPOcbCbzh4PDpHs5yZmY",
    apiKey: process.env.OPENAI_API_KEY,
});
const openai = new OpenAIApi(configuration);
// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
export const sayHello = https.onCall(async (data, context) => {
    const completion = await openai.createCompletion({
        model: "text-davinci-003",
        prompt: data.prompt,
        max_tokens:200
      });
    logger.info(completion.data.choices, {structuredData: true});
    
    return {
        data: completion.data.choices.map((e) => e.text).join(' ')
    };
  });
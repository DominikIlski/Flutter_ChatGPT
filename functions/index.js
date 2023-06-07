import * as dotenv from 'dotenv';
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
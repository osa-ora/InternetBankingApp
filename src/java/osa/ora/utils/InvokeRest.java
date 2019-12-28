/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package osa.ora.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

/**
 *
 * @author ooransa
 */
public class InvokeRest {

    public static String invokePost(String input, String URL) {
        String response = null;
        try {
            System.out.println("User input:" + input);
            URL url = new URL(URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes());
            os.flush();
            if (conn.getResponseCode() != HttpURLConnection.HTTP_CREATED
                    && conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
                return null;
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream())));
            String output;
            System.out.println("Output from Server .... \n");
            while ((output = br.readLine()) != null) {
                if (response == null) {
                    response = "";
                }
                System.out.println(output);
                response += output;
            }
            conn.disconnect();
            return response;
        } catch (MalformedURLException e) {
            System.out.println("Service URL is malformed: " + e.getLocalizedMessage());
        } catch (Exception e) {
            System.out.println("Service is down: " + e.getLocalizedMessage());
        }
        return null;
    }

    public static String invokeGet(String URL) {
        System.out.println("Target URL:" + URL);
        String response = null;
        try {
            URL url = new URL(URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");
            if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
                return null;
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    (conn.getInputStream())));
            String output;
            System.out.println("Output from Server .... \n");
            while ((output = br.readLine()) != null) {
                if (response == null) {
                    response = "";
                }
                System.out.println(output);
                response += output;
            }
            conn.disconnect();
            return response;
        } catch (MalformedURLException e) {
            System.out.println("Service URL is malformed: " + e.getLocalizedMessage());
        } catch (Exception e) {
            System.out.println("Service is down: " + e.getLocalizedMessage());
        }
        return null;
    }
}

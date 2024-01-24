package com.dealim.service;

import com.dealim.domain.Movie;
import info.movito.themoviedbapi.TmdbApi;
import info.movito.themoviedbapi.TmdbMovies;
import info.movito.themoviedbapi.model.MovieDb;
import info.movito.themoviedbapi.model.core.MovieResultsPage;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;
import org.json.JSONObject;

import java.util.List;

public class TestService {
    public static void main(String[] args) {
        TmdbMovies movies = new TmdbApi("41774864868b4413dd1e4dfe8f680899").getMovies();

        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url("https://api.themoviedb.org/3/movie/" + 2232 + "?language=en-US")
                .get()
                .addHeader("accept", "application/json")
                .addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MTc3NDg2NDg2OGI0NDEzZGQxZTRkZmU4ZjY4MDg5OSIsInN1YiI6IjY1YWY2MGZlZDEwMGI2MDBjYjgxNzNlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4sF4zILFE1cDrsXNa18RAZJ5cd_8c1ygbf_nszng4zA")
                .build();
        try {
            Response response = client.newCall(request).execute();
            if (response.isSuccessful()) {
                ResponseBody body = response.body();
                if (body != null) {
                    String responseBody = body.string();
                    JSONObject jsonObject = new JSONObject(responseBody);
                    String overview = jsonObject.getString("overview");

                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


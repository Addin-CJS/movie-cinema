package com.dealim.service;

import com.dealim.domain.Movie;
import com.dealim.repository.MovieRepository;
import info.movito.themoviedbapi.TmdbApi;
import info.movito.themoviedbapi.TmdbMovies;
import info.movito.themoviedbapi.model.MovieDb;
import info.movito.themoviedbapi.model.core.MovieResultsPage;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class TmdbApiService {
    @Autowired
    private MovieRepository movieRepository;

    public void insertMovies() {
        TmdbMovies movies = new TmdbApi("41774864868b4413dd1e4dfe8f680899").getMovies();
        MovieResultsPage movieResultsPage = movies.getPopularMovies("kr", 6);
        List<MovieDb> movieDbs = movieResultsPage.getResults();

        for (MovieDb movieDb : movieDbs) {
            String genre = movies.getMovie(movieDb.getId(), "kr").getGenres().get(0).toString();
            int startIdx = genre.indexOf("[");
            String subbedGenre = genre.substring(0, startIdx - 1);

            OkHttpClient client = new OkHttpClient();
            Request request = new Request.Builder()
                    .url("https://api.themoviedb.org/3/movie/" + movieDb.getId() + "?language=en-US")
                    .get()
                    .addHeader("accept", "application/json")
                    .addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MTc3NDg2NDg2OGI0NDEzZGQxZTRkZmU4ZjY4MDg5OSIsInN1YiI6IjY1YWY2MGZlZDEwMGI2MDBjYjgxNzNlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4sF4zILFE1cDrsXNa18RAZJ5cd_8c1ygbf_nszng4zA")
                    .build();
            Request request2 = new Request.Builder()
                    .url("https://api.themoviedb.org/3/movie/" + movieDb.getId() + "/videos?language=en-US")
                    .get()
                    .addHeader("accept", "application/json")
                    .addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MTc3NDg2NDg2OGI0NDEzZGQxZTRkZmU4ZjY4MDg5OSIsInN1YiI6IjY1YWY2MGZlZDEwMGI2MDBjYjgxNzNlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4sF4zILFE1cDrsXNa18RAZJ5cd_8c1ygbf_nszng4zA")
                    .build();

            try {
                Response response = client.newCall(request).execute();
                Response response2 = client.newCall(request2).execute();

                if (response.isSuccessful()) {
                    ResponseBody body = response.body();
                    ResponseBody body2 = response2.body();

                    if (body != null) {
                        String responseBody = body.string();
                        JSONObject jsonObject = new JSONObject(responseBody);
                        String mvTitle = jsonObject.getString("title");

                        JSONArray genresArray = jsonObject.getJSONArray("genres");
                        String mvGenre = genresArray.getJSONObject(0).getString("name");

                        String mvOverview = jsonObject.getString("overview");
                        String mvImg = "https://image.tmdb.org/t/p/w500" + jsonObject.getString("poster_path");
                        Integer mvRuntime = jsonObject.getInt("runtime");
                        Float mvPopularity = jsonObject.getFloat("popularity");
                        LocalDate mvReleaseDate = LocalDate.parse(jsonObject.getString("release_date"), DateTimeFormatter.ofPattern("yyyy-MM-dd"));

                        Character isAdult = jsonObject.getBoolean("adult") ? 'Y' : 'N';

                        String mvVideo = "https://www.youtube.com/watch?v=" + new JSONObject(body2.string()).getJSONArray("results").getJSONObject(0).getString("key");

                        Movie movie = Movie.builder()
                                .mvTitle(mvTitle)
                                .mvGenre(mvGenre)
                                .mvDescription(mvOverview)
                                .mvImg(mvImg)
                                .mvRuntime(mvRuntime)
                                .mvPopularity(mvPopularity)
                                .isAdult(isAdult)
                                .mvReleaseDate(mvReleaseDate)
                                .mvVideo(mvVideo)
                                .build();
//                        System.out.println(movie);
                        movieRepository.save(movie);
                    }
                }

                response.close();
                response2.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

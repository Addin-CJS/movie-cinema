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
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OpenApiService {
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
            try {
                Response response = client.newCall(request).execute();
                if (response.isSuccessful()) {
                    ResponseBody body = response.body();
                    if (body != null) {
                        String responseBody = body.string();
                        JSONObject jsonObject = new JSONObject(responseBody);
                        String overview = jsonObject.getString("overview");
                        Movie movie = Movie.builder()
                                .mvTitle(movieDb.getTitle())
                                .mvImg("https://image.tmdb.org/t/p/w500" + movieDb.getPosterPath())
                                .mvGenre(subbedGenre)
                                .mvDescription(overview)
                                .build();

//                        movieRepository.save(movie);
                        System.out.println(movie);
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

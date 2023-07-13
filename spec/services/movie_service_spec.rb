require 'rails_helper'

RSpec.describe MovieService  do
  context "class methods" do
    context ".top_movies" do
      it "returns movie data", :vcr do
        top_movies = MovieService.top_movies
        expect(top_movies).to be_a(Hash)
        expect(top_movies[:results].size).to eq(20)
        
        expect(top_movies[:results]).to be_an(Array)
        movie_data = top_movies[:results].first

        expect(movie_data).to have_key(:title)

        expect(movie_data).to have_key(:vote_average)
      end
    end

    context ".search_movies(search)" do
      it "returns the search results from the movie database", :vcr do
        search_results = MovieService.search_movies("Godfather")
        expect(search_results).to be_a(Hash)
        expect(search_results[:results].size).to eq(20)
        
        expect(search_results[:results]).to be_an(Array)
        movie_data = search_results[:results].first

        expect(movie_data).to have_key(:title)

        expect(movie_data).to have_key(:vote_average)
      end
    end

    context ".movie_details(movie_id)" do
      it "returns the movie details from the movie database", :vcr do
        movie_details = MovieService.movie_details(238)
        expect(movie_details).to be_a(Hash)
        expect(movie_details).to have_key(:title)
        expect(movie_details).to have_key(:vote_average)
        expect(movie_details).to have_key(:runtime)
        expect(movie_details).to have_key(:genres)
        expect(movie_details).to have_key(:overview)
      end
    end

    context ".movie_cast(movie_id)" do
      it "returns the movie cast from the movie database", :vcr do
        cast_details = MovieService.movie_cast(238)
        expect(cast_details).to be_a(Hash)
        expect(cast_details).to have_key(:cast)
        expect(cast_details[:cast].first).to have_key(:name)
        expect(cast_details[:cast].first).to have_key(:character)
      end
    end

    context '.movie_reviews(movie_id)' do
      it 'returns the movie reviews from the movie database', :vcr do
        review_details = MovieService.movie_reviews(238)
        expect(review_details).to be_a(Hash)
        expect(review_details).to have_key(:results)
        expect(review_details[:results].first).to have_key(:author)
        expect(review_details[:results].first).to have_key(:content)
        expect(review_details).to have_key(:total_results)
      end
    end
  end
end
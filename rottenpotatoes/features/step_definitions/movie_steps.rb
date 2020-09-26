# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end



Then /I should see "(.*)" before "(.*)"/ do |e1, e2|

  expect(page.body).to have_content(/#{e1}.*#{e2}.*/) #regex to check if e1 comes before e2
end



When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|

  if uncheck == 'un'
    rating_list.split(', ').each{ |x| step %{I uncheck "ratings_#{x}"}}
  else
    rating_list.split(', ').each{ |x| step %{I check "ratings_#{x}"}}
  end
    
end

Then /I should see all the movies/ do
  
  rows = page.body.scan(/<tr>/).count
  expect(rows).to eq(Movie.all.count + 1) #+1 to count the table headers row
end

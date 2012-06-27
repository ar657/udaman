module DataListsHelper
  require 'csv'

  def csv_helper
    CSV.generate do |csv| 
      series_data = @data_list.series_data
      sorted_names = series_data.keys.sort
      dates_array = @data_list.data_dates
       
      csv << [""] + sorted_names
      dates_array.each do |date|
        csv << [date] + sorted_names.map {|series_name| series_data[series_name][date]}
      end
    end
  end
  
  def dl_linked_version(description)
    return "" if description.nil?
    new_words = []
    description.split(" ").each do |word|
      #new_word = word.index('@').nil? ? word : link_to(word, {:action => 'show', :id => word.ts.id})
      new_word = word
      begin
        new_word = (word.index('@').nil? or word.split(".")[-1].length > 1) ? word : link_to(word, :controller => 'series', :action => 'show', :id => word.ts.id) 
      rescue
        new_word = word
      end
      new_words.push new_word
    end
    return new_words.join(" ")
  end
  
end


# array2d = []
# array2d.push([""] + sorted_names)
# dates_array.each do |date|
#   array2d.push([date] + sorted_names.map {|series_name| series_data[series_name][date]})
# end
# csv << [""] + sorted_names
# dates_array.each do |date|
#   csv << [date] + sorted_names.map {|series_name| series_data[series_name][date]}
# end
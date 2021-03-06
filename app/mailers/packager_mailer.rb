class PackagerMailer < ActionMailer::Base
  default :from => "udaman@hawaii.edu"
  
  # def rake_notification(rake_task, download_string, error_string, summary_string)
  #   @download_string = download_string
  #   @error_string = error_string
  #   @summary_string = summary_string
  #   mail(:to => ["bentut@gmail.com","btrevino@hawaii.edu"], :subject => "UDAMAN New Download or Error (#{rake_task})")
  # end

  def rake_notification(rake_task, download_results, errors, series, output_path, is_error)
    @download_results = download_results
    @errors = errors
    @series = series
    @output_path = output_path
    @dates = Series.get_all_dates_from_data(@series)
    subject = "UDAMAN Error (#{rake_task})" if is_error
    subject = "UDAMAN New Download (#{rake_task})" unless is_error
    mail(:to => ["btrevino@hawaii.edu"], :subject => subject)
  end
  
  def rake_error(e, output_path)
    @error = e
    @output_path = output_path
    mail(:to => ["btrevino@hawaii.edu"], :subject => "Rake failed in an unexpected way")
  end

  def visual_notification(new_dps = 0, changed_files = 0, new_downloads = 0)
    attachments.inline['photo.png'] = File.read('/Users/Shared/Dev/udaman/script/investigate_visual.png')
    attachments['photo.png'] = File.read('/Users/Shared/Dev/udaman/script/investigate_visual.png')
    subject = "Udaman Download Report: #{new_dps.to_s + " new data points / " unless new_dps == 0} #{new_downloads.to_s + " updated downloads / " unless new_downloads == 0} #{changed_files.to_s + " modified update spreadsheets" unless changed_files == 0}"
    mail(:to => ["btrevino@hawaii.edu", "james29@hawaii.edu", "icintina@gmail.com", "fuleky@hawaii.edu", "bonham@hawaii.edu","ar657@drexel.edu", "qianxue@hawaii.edu", "atsushis@hawaii.edu"], :subject => subject)
    #mail(:to => ["bentut@gmail.com"], :subject => subject)
  end
  
  def download_link_notification(handle = nil, url = nil, save_path = nil, created = false)
    subject = "Udaman found and created a new download link for #{handle}" if created
    subject = "Udaman tried but failed to create a new download link for #{handle}" unless created
    @handle = handle
    @url = url
    @save_path = save_path
    mail(:to => ["btrevino@hawaii.edu"], :subject => subject)
  end
end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    
  def uploadify_options(options = {})
    @uploadify_options ||= {:dialog_file_description => options[:dialog_file_description] || "Photos",
                            :allowed_extensions      => options[:allowed_extensions] || Photo::EXTENSIONS,
                            :max_size                => options[:max_size] || Photo::MAX_SIZE,
                            :allow_multiple_files    => options[:allow_multiple_files] || true,
                            :url                     => options[:url] || photos_path,
                            :id                      => options[:id] || "photo_photo"}
  end
  
  def render_uploadify(options = {})
    uploadify_options(options) #sets uploadify options
    javascript_tag("window._token = '#{get_authenticity_token}'") <<
    javascript_include_tag("uploadify/swfobject") << 
    javascript_include_tag("uploadify/jquery.uploadify.v2.1.0.min") <<
    render(:partial => "/photos/uploadify_script")
  end
  
  def uploadify_cancel(text = "Cancel", options = {})
    link_to_function text, {:id => "uploadify_cancel", :style => "display:none"}.merge(options) do |page|
      page << "$('##{uploadify_options[:id]}').uploadifyClearQueue();
               $('#uploadify_cancel').hide();
               $('#uploadify_submit').show()"
    end
  end
  
  def uploadify_submit(text = "Upload", options = {})
    link_to_function text, {:class => "button", :id => "uploadify_submit"}.merge(options) do |page|
      page << "$('##{uploadify_options[:id]}').uploadifyUpload();
               $('#uploadify_submit').hide();
               $('#uploadify_cancel').show()"
    end
  end
  
  def get_authenticity_token
    u form_authenticity_token if protect_against_forgery?
  end
  
  def get_session_key_name
    ActionController::Base.session_options[:key]
  end
  
  def get_session_key
    u cookies[get_session_key_name]
  end
  
  def allowed_extensions
    uploadify_options[:allowed_extensions].collect { |ext| "*.#{ext}" }.join(';')
  end  
  
end

module ApplicationHelper

  def active?(path)
    'active' if current_page?(path)
  end

  def toastr_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}('#{escape_javascript(message)}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

end

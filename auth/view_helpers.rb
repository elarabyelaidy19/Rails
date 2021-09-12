# View helpers are Ruby methods that can be called from your view. 
# The job of view helpers is to hold view specific code that DRYs up templates. 
# They go in the folder app/helpers. All the methods in these modules will be available in every view.


# app/helpers/application_helper.rb
module ApplicationHelper
  def highlight(text)
    "<strong class=\"highlight\">#{h(text)}</strong>".html_safe
  end

  def picture_for(user)
    html = '<div class="user-picture">'
    html += "<img src=\"#{user.picture_url}\" alt=\"#{h(user.name)}\">"
    html += '</div>'

    html.html_safe
  end
end


##################################################################  
# ESCAPING HTML 
################################################################## 

<%= '<p>This paragraph tag will be escaped</p>' %>
<!--
Outputs: &lt;p&gt;This paragraph tag will be escaped&lt;/p&gt;
--> 

#################### 
# Will not work without html.safe 

# app/helpers/application_helper.rb
module ApplicationHelper
  def highlight(text)
    "<strong class=\"highlight\">#{text}</strong>".html_safe
  end
end


## This gonna be work h == html.safe
# app/helpers/application_helper.rb
module ApplicationHelper
  def highlight(text)
    "<strong class=\"highlight\">#{h(text)}</strong>".html_safe
  end
end

<!-- app/views/cats/show.html.erb -->
<p>
  How can one not like <%= highlight "cats" %>? They are my favorite!
</p>

<%= picture_for @cat %> 




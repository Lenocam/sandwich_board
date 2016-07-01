<%
=begin %>
class AlbumGallery < ActiveRecord::Base
	belongs_to :gallery
	belongs_to :album
end
<%
=end %>

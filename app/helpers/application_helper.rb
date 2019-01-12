module ApplicationHelper
  
  def isPicture?(file)
    pictureExt = %w(.jpg .jpeg .gif .png)
    ext=File.extname(file).downcase
    return pictureExt.include?(ext)
  end
  
  def isVideo?(file)
    videoExt=%(.mp4 .mov .wmv)
    ext=File.extname(file).downcase
    return videoExt.include?(ext)
  end
  
  def isFriend?(id_a,id_b)
    
    if id_a == id_b
      return false
    end
    
    r1 = Relationship.find_by(user_id: id_a,friend_id: id_b)
    r2 = Relationship.find_by(user_id: id_b,friend_id: id_a)
    
    if  r1.present? 
      return r1.status
    elsif r2.present?
      return r2.status
    else
      return false
    end
  end
  
  def searchRoomId(id_a,id_b)
    
    if id_a == id_b
      return 0
    else
      entries = Entry.where(user_id: id_a)

      entries.each do |e|
        if Entry.where(user_id: id_b,room_id: e.room_id).exists?
          return e.room_id
        end
      end
      
      return 0
      
    end
  end
  
  def enterRoom(id_a,id_b)
    room_id = searchRoomId(id_a,id_b)
    
    if room_id == 0
      room = Room.new
    else
      room = Room.find(room_id)
    end
    
    return room
  end
  
  def userImage(user)
    if user.image?
      user.image.url(:thumb)
    else
      'user.jpg'
    end
  end 
  
end

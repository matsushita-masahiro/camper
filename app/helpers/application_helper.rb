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
    r1 = Relationship.where(user_id: id_a,friend_id: id_b)
    r2 = Relationship.where(user_id: id_b,friend_id: id_a)
    
    if r1.exists? || r2.exists?
      return true
    else
      return false
    end
  end
  
  def searchRoomId(id_a,id_b)
    entries = Entry.where(user_id: id_a)
    
    entries.each do |e|
      if Entry.where(user_id: id_b,room_id: e.room_id).exists?
        return e.room_id
      end
    end
    
    return 0
  end

end

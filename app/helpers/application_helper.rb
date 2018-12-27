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

end

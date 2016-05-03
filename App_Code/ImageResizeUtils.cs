using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Drawing.Imaging;
/// <summary>
/// Summary description for ImageResizeUtils
/// </summary>

public static class ImageResizeUtils
	{
        public static void ResizeImage(string locationOfImage,int width,int height)
        {
            Image original = Image.FromFile(locationOfImage);
            Image resized = ResizeImage(original, new Size(width, height));
            MemoryStream memStream = new MemoryStream();
            resized.Save(memStream, ImageFormat.Jpeg);
        }
        

        private static Image ResizeImage(Image image, Size size)
        {
            bool preserveAspectRatio = true;
            int newWidth;
            int newHeight;
            if (preserveAspectRatio)
            {
                int originalWidth = image.Width;
                int originalHeight = image.Height;
                float percentWidth = (float)size.Width / (float)originalWidth;
                float percentHeight = (float)size.Height / (float)originalHeight;
                float percent = percentHeight < percentWidth ? percentHeight : percentWidth;
                newWidth = (int)(originalWidth * percent);
                newHeight = (int)(originalHeight * percent);
            }
            else
            {
                newWidth = size.Width;
                newHeight = size.Height;
            }
            Image newImage = new Bitmap(newWidth, newHeight);
            using (Graphics graphicsHandle = Graphics.FromImage(newImage))
            {
                graphicsHandle.InterpolationMode = InterpolationMode.HighQualityBicubic;
                graphicsHandle.DrawImage(image, 0, 0, newWidth, newHeight);
            }
            return newImage;
        }
    }


	

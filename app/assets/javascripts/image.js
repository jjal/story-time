function tiltShift(c)
{
  //start out by adding some pop
  var ctx = c.getContext("2d");
  Pixastic.process(canvas, "hsl", {hue:0,saturation:60,lightness:0, 'leaveDOM': true}, function(result) { ctx.drawImage(result,0,0);
    Pixastic.process(canvas, "brightness", {brightness:10,contrast:0.4, 'leaveDOM': true}, function(result) { ctx.drawImage(result,0,0);
      //make a copy of the canvas
      var blurCanvas = document.createElement("canvas");
      blurCanvas.width=c.width;
      blurCanvas.height=c.height;
      var blurCtx = blurCanvas.getContext("2d");
      //blur the image to the new canvas
      Pixastic.process(c,"blurfast",{amount:5, 'leaveDOM': true},  function(result) { blurCtx.drawImage(result,0,0);
        
      var w = blurCanvas.width, h = blurCanvas.height;
      // pull the entire image into an array of pixel data
      var sharpData = ctx.getImageData(0, 0, w, h);
      var blurData = blurCtx.getImageData(0, 0, w, h);
      //compose a new image from the two
      for(var i=0;i<sharpData.data.length;i+=4)
      {
          sharpPixel = new Array(sharpData.data[i],sharpData.data[i+1],sharpData.data[i+2],sharpData.data[i+3]);
          blurPixel = new Array(blurData.data[i],blurData.data[i+1],blurData.data[i+2],blurData.data[i+3]);
          weight = getBlurWeight(i,w,h);//,luminance(blurPixel), luminance(sharpPixel));
          for(var j=0;j<4;j++)
            sharpData.data[i+j] = (blurPixel[j]*(weight)+(sharpPixel[j]*(1-weight)));
      }
      //slap it back on the original canvas
      ctx.putImageData(sharpData,0,0);
      });
    }); 
  });
}
function plainblur(c)
{
  //start out by adding some pop
  var ctx = c.getContext("2d");
  Pixastic.process(canvas, "hsl", {hue:0,saturation:60,lightness:0, 'leaveDOM': true}, function(result) { ctx.drawImage(result,0,0);
    Pixastic.process(canvas, "brightness", {brightness:10,contrast:0.4, 'leaveDOM': true}, function(result) { ctx.drawImage(result,0,0);
      //blur the image 
      Pixastic.process(c,"blurfast",{amount:1, 'leaveDOM': true},  function(result) { ctx.drawImage(result,0,0); });
    }); 
  });
}
function getBlurWeight(i,w,h,u,v)
{
  var y = Math.floor(i / 4 / w);
  diff = Math.abs(h/2 - y);
  var factor = diff/(h/2.0);
  factor = 1/(1+Math.exp(-15*(factor-0.5))) //on a curve
  //factor = factor * (1 + v - u);
  return factor;
}

function luminance(pixel)
{
  return (0.299*pixel[0] + 0.587*pixel[1] + 0.114*pixel[2]) / 255;
}

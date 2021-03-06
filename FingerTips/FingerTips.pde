/*******************************************************************************
 
 INTEL CORPORATION PROPRIETARY INFORMATION
 This software is supplied under the terms of a license agreement or nondisclosure
 agreement with Intel Corporation and may not be copied or disclosed except in
 accordance with the terms of that agreement
 Copyright(c) 2012 Intel Corporation. All Rights Reserved.
 
 *******************************************************************************/
//Updated to Beta3
import intel.pcsdk.*;

PImage labelMap;
PXCUPipeline session;

void setup() {
  size(640, 480);
  session = new PXCUPipeline(this);
  if (!session.Init(PXCUPipeline.GESTURE)) {
    print("Failed to initialize PXCUPipeline\n");
    exit();
  }

  int[] labelMap_Size = new int[2];
  if(session.QueryLabelMapSize(labelMap_Size))
  {
    print("Depth Size("+labelMap_Size[0]+","+labelMap_Size[1]+")\n");
    labelMap=createImage(labelMap_Size[0], labelMap_Size[1], RGB);
  }
}

void draw() { 
  background(0);

  if (session.AcquireFrame(true)) {
      if(session.QueryLabelMapAsImage(labelMap))
        image(labelMap, 0, 0, 640, 480);


      //Hand 1, first hand detected, left or right specific
      PXCMGesture.GeoNode hand1Thumb=new PXCMGesture.GeoNode();
      PXCMGesture.GeoNode hand1Index = new PXCMGesture.GeoNode();
      PXCMGesture.GeoNode hand1Middle = new PXCMGesture.GeoNode(); 
      PXCMGesture.GeoNode hand1Ring = new PXCMGesture.GeoNode(); 
      PXCMGesture.GeoNode hand1Pinky = new PXCMGesture.GeoNode();

      //Hand 2, second hand detected
      PXCMGesture.GeoNode hand2Thumb = new PXCMGesture.GeoNode();
      PXCMGesture.GeoNode hand2Index = new PXCMGesture.GeoNode();
      PXCMGesture.GeoNode hand2Middle = new PXCMGesture.GeoNode();
      PXCMGesture.GeoNode hand2Ring = new PXCMGesture.GeoNode();
      PXCMGesture.GeoNode hand2Pinky = new PXCMGesture.GeoNode();


      //Scale tracked points
      scale(2); //make everything twice as large
   
      //Drawing the fingertips on screen
      fill(255,0,0);
      if (session.QueryGeoNode(PXCMGesture.GeoNode.LABEL_BODY_HAND_PRIMARY|PXCMGesture.GeoNode.LABEL_FINGER_THUMB, hand1Thumb)) {
        ellipse(hand1Thumb.positionImage.x, hand1Thumb.positionImage.y, 5, 5);
        text("   thumb", hand1Thumb.positionImage.x, hand1Thumb.positionImage.y);
      }
      
      if (session.QueryGeoNode(PXCMGesture.GeoNode.LABEL_BODY_HAND_PRIMARY|PXCMGesture.GeoNode.LABEL_FINGER_INDEX, hand1Index)) {
        ellipse(hand1Index.positionImage.x, hand1Index.positionImage.y, 5, 5);
        text("   index", hand1Index.positionImage.x, hand1Index.positionImage.y);
      }
      
      if (session.QueryGeoNode(PXCMGesture.GeoNode.LABEL_BODY_HAND_PRIMARY|PXCMGesture.GeoNode.LABEL_FINGER_MIDDLE, hand1Middle)) {
        ellipse(hand1Middle.positionImage.x, hand1Middle.positionImage.y, 5, 5);
        text("   middle", hand1Middle.positionImage.x, hand1Middle.positionImage.y);
      }
      
      if (session.QueryGeoNode(PXCMGesture.GeoNode.LABEL_BODY_HAND_PRIMARY|PXCMGesture.GeoNode.LABEL_FINGER_RING, hand1Ring)) {
        ellipse(hand1Ring.positionImage.x, hand1Ring.positionImage.y, 5, 5);
        text("   ring", hand1Ring.positionImage.x, hand1Ring.positionImage.y);
      }

      if (session.QueryGeoNode(PXCMGesture.GeoNode.LABEL_BODY_HAND_PRIMARY|PXCMGesture.GeoNode.LABEL_FINGER_PINKY, hand1Pinky)) {
        ellipse(hand1Pinky.positionImage.x, hand1Pinky.positionImage.y, 5, 5);
        text("   pinky", hand1Pinky.positionImage.x, hand1Pinky.positionImage.y);
      }



      //Hand2
      if (session.QueryGeoNode(PXCMGesture.GeoNode.LABEL_BODY_HAND_SECONDARY|PXCMGesture.GeoNode.LABEL_FINGER_THUMB, hand2Thumb)) {
        ellipse(hand2Thumb.positionImage.x, hand2Thumb.positionImage.y, 5, 5);
        text("   thumb", hand2Thumb.positionImage.x, hand2Thumb.positionImage.y);
      }
      
      if (session.QueryGeoNode(PXCMGesture.GeoNode.LABEL_BODY_HAND_SECONDARY|PXCMGesture.GeoNode.LABEL_FINGER_INDEX, hand2Index)) {
        ellipse(hand2Index.positionImage.x, hand2Index.positionImage.y, 5, 5);
        text("   index", hand2Index.positionImage.x, hand2Index.positionImage.y);
      }
      
      if (session.QueryGeoNode(PXCMGesture.GeoNode.LABEL_BODY_HAND_SECONDARY|PXCMGesture.GeoNode.LABEL_FINGER_MIDDLE, hand2Middle)) {
        ellipse(hand2Middle.positionImage.x, hand2Middle.positionImage.y, 5, 5);
        text("   middle", hand2Middle.positionImage.x, hand2Middle.positionImage.y);
      }
      
      if (session.QueryGeoNode(PXCMGesture.GeoNode.LABEL_BODY_HAND_SECONDARY|PXCMGesture.GeoNode.LABEL_FINGER_RING, hand2Ring)) {
        ellipse(hand2Ring.positionImage.x, hand2Ring.positionImage.y, 5, 5);
        text("   ring", hand2Ring.positionImage.x, hand2Ring.positionImage.y);
      }
      
      if (session.QueryGeoNode(PXCMGesture.GeoNode.LABEL_BODY_HAND_SECONDARY|PXCMGesture.GeoNode.LABEL_FINGER_PINKY, hand2Pinky)) {
        ellipse(hand2Pinky.positionImage.x, hand2Pinky.positionImage.y, 5, 5);
        text("   pinky", hand2Pinky.positionImage.x, hand2Pinky.positionImage.y);
      }  

    session.ReleaseFrame();
  }
}

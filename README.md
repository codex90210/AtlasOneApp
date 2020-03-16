# AtlasOneApp
Couponing on the Go
This project does not include GoogleServices-Info.plist in order to send and receive data requests from Firebase.
You will need to create a Firebase project to generate your own Firebase API key and set up your JSON data in order for the application to function.

# Screenshots
![](SignUp%20AO%20SS_iphonexspacegrey_portrait.png)
![](Main%20Screen%20AO%20SS_iphonexspacegrey_portrait.png)
![](CaliSurf%20AO%20SS_iphonexspacegrey_portrait.png)
![](SwipeScreen%20AO%20SS_iphonexspacegrey_portrait.png)

# Firebase Setup / How To Use App
The link below should provide the process of setting up a Firebase Project. Google provides a straight forward approach in getting you started to set up your own Firebase account if you're not familiar with it. 

https://firebase.google.com

AtlasOne uses Firebase Authentication, Storage for Pictures (Coupon Pictures, Logos, and Ad Images) and Realtime Database for JSON setup. 

Realtime Database should have three components - Coupons, Advertisement Set, and a Used List (if you prefer to persist data via Firebase for users)

The following should be in JSON format:

The labels should be typed verbatim unless otherwise, you've modified the snapshots string values in XCode.  

The Advertisement Set should have childrens labled -- "brandTitle", "imageUrl", "linkTitle", and "urlLink". In Codebase I've labeled the root parent "adSet" and the child of "adSet" as "advertList"

JSON format as follows:

adSet<br/>
  &nbsp;&nbsp;advertList<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;Advert ID [List of all Advert ID -- Name it to whatever you want] within this ID each child should have snapshot values named "brandTitle", "imageUrl", "linkTitle", and "urlLink" to correspond in what's written in XCode -- adsViewListController.
     
     brandTitle: [Text Value]
     imageUrl: [Value should contain imageURLLink from your Firebase Storage]
     linkTitle: [Text Value]
     urlLink: [Web URL link to brand site]<br/>

Coupons should have childrens labled -- "couponCard" (Image of the card itself), "couponDiscount", "couponLogoImg", "couponLogoName". In codebase I've labeled the root parent "PassCard" and the child of "PassCard" as "Coupons"

JSON format as follows:

PassCard<br/> 
  &nbsp;&nbsp;Coupons<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;PassCardID [List of all PassCards ID -- Name it to whatever you want] within this ID each child have snapshot values named "couponCard", "couponDiscount", "couponLogoImg", and "couponLogoName" to correspond in XCode -- MainViewController.
      
      couponCard: [Value should contain image URLLink from Your Firebase Storage]
      couponDiscount: [Text Value]
      couponLogoImg: [Value should contain image URLLink from your Firebase Storage]
      couponLogoName: [Text Value]<br/>

Storage Settings -- It is used to store pictures for Advertisement Images for "imageUrl", Coupon Card Images for "couponCard", and Coupon Logo Images for "couponLogoImg". Once the pictures in each set are uploaded to Firebase Storage, each url link can be copied and pasted into each corresponding JSON value to imageURL, couponCard, and couponLogoImg.

UsedList is automatically updated to the server. No need to set up JSON Structure in firebase as it's already in codebase.

Once you have your API Keys established and linked to your Xcode project you should be able to extract and add data to your Firebase Server. 

I hope this works for you and you enjoy exploring my first app I've created.

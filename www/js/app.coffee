app = angular.module("ionic-app", [
  "ionic"
  "ngCordova"
])

app.run ["$ionicPlatform", "$window", ($ionicPlatform, $window) ->
  $ionicPlatform.ready ->
    $window.cordova.plugins.Keyboard.hideKeyboardAccessoryBar true if ($window.cordova and $window.cordova.plugins.Keyboard)
    StatusBar.styleDefault() if $window.StatusBar
]

app.controller "MainCtrl", ["$scope", "$ionicSideMenuDelegate", ($scope, $ionicSideMenuDelegate) ->
  $scope.toggleLeftSideMenu = ->
    $ionicSideMenuDelegate.toggleLeft()

  $scope.toggleRightSideMenu = ->
    $ionicSideMenuDelegate.toggleRight()
]

app.controller "SideMenuIndexCtrl", ["$scope", "$cordovaFile", "$window", "$ionicPlatform", ($scope, $cordovaFile, $window, $ionicPlatform) ->
  console.log "SideMenuIndexCtrl"

  $scope.debug = ["Hello"]
  $ionicPlatform.ready().then ->
    $scope.debug.push $window.cordova?.file.externalDataDirectory
    $cordovaFile.checkFile("file:///android_asset/www/index.json").then ((result) ->
      $scope.debug.push "Win"
    ), (err) ->
      $scope.debug.push "FAILURE!, #{err}"
]

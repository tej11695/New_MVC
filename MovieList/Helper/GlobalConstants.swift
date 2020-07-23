
import Foundation
import UIKit

var isDevelopment = false
let APPNAME : String = "TLV"
let TokenHeader : String = "Bearer"

//Shadow
let shadowColor: UIColor = UIColor(hexString: "#C7C7C7")
let shadowOpacity: Float = 1
let shadowOffset: CGSize = CGSize(width: 0.0, height: 1.0)
let shadowRadius: CGFloat = 3

extension Notification.Name {
    
    static let REFRESH_FEVOURITE_RESTAURANT_LIST             =   Notification.Name("REFRESH_FEVOURITE_RESTAURANT_LIST")
}

struct CustomFontName {
    
    static var helveticaNeue            =   "HelveticaNeue"
    static var helveticaNeueBold        =   "HelveticaNeue-Bold"
    static var helveticaNeueItalic      =   "HelveticaNeue-Italic"
}


let APP_REGULAR_FONT = CustomFontName.helveticaNeue
let APP_BOLD_FONT = CustomFontName.helveticaNeueBold
let APP_ITALIC_FONT = CustomFontName.helveticaNeueItalic


struct Color {

        //#133B80
    static var APP_THEME_COLOR_SPACE_GRAY        =   #colorLiteral(red: 0.1764705882, green: 0.2274509804, blue: 0.2901960784, alpha: 1)
    static var APP_THEME_COLOR_YELLOW            =   #colorLiteral(red: 0.9215323329, green: 0.8876507878, blue: 0.2920791507, alpha: 1)
    static var APP_COLOR_LIGHT_GRAY              =   #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    static var APP_COLOR_WHITE                   =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static var APP_COLOR_DARK_BLUE               =   #colorLiteral(red: 0.07450980392, green: 0.262745098, blue: 0.5411764706, alpha: 1)
}

struct StatusCode {
    
    static let error                    =   0
    static let success                  =   1
    static let sessionExpired            =   4
    static let newUser                  =   5
    
}

enum LoginType: String {
    
    case normal = "NORMAL"
    case facebook = "FACEBOOK"
    case google = "GOOGLE"
}

class MarkTypeItem {
    var status = ""

    init(status: String) {
        
        self.status = status
    }
}

enum MarkType: String {
    
    case yes = "y"
    case no = "n"
    case notAvailable = "N\\A"
    case other = "other"
    
    var instance: MarkTypeItem {
        
        switch self {
            
        //Side menu items
        case .yes:              return MarkTypeItem(status: "1")
        case .no:               return MarkTypeItem(status: "2")
        case .notAvailable:     return MarkTypeItem(status: "3")
        case .other:            return MarkTypeItem(status: "0")
        }
    }
}
//struct APP_LAYOUT
//{
//    static let IS_IPAD = UI_USER_INTERFACE_IDIOM() == .pad
//    static let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == .phone
//    static let IS_RETINA = UIScreen.main.scale >= 2.0
//    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
//    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
//    static let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
//    static let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)
//    static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH < 568.0
//    static let IS_IPHONE_5 = IS_IPHONE && SCREEN_MAX_LENGTH == 568.0
//    static let IS_IPHONE_6 = IS_IPHONE && SCREEN_MAX_LENGTH == 667.0
//    static let IS_IPHONE_6P = IS_IPHONE && SCREEN_MAX_LENGTH == 736.0
//    static let IS_IPHONE_X = IS_IPHONE && SCREEN_MAX_LENGTH == 812.0  //xs
//    static let IS_IPHONE_XR = IS_IPHONE && SCREEN_MAX_LENGTH == 896.0  // xsMax
//
//    static let IS_IOS_8 = Float(UIDevice.current.systemVersion) ?? 0.0 >= 8.0
//}
//MARK: - API
struct API {
   
//Base API
    static var SERVER_URL = "https://api.themoviedb.org/3/discover/movie?api_key=14bc774791d9d20b3a138bb6e26e2579&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page="
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w185"
    static let BG_IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500"
    static var LIVE_URL = ""
    static var BASE_URL = API.SERVER_URL    
}

class UserDetail: NSObject
{
    static let shared = UserDetail()
    
    static var user_ID:String                = ""
    static var user_FirstName:String         = ""
    static var user_LastName:String          = ""
    static var user_MiddleName:String        = ""
    static var user_Email:String             = ""

}
class CompanyDetail: NSObject
{
    static let shared = CompanyDetail()
    
    static var company_ID:Int!
    static var company_Name:String         = ""
    static var company_Email:String        = ""
    
}
class CardDetail: NSObject
{
    static let shared = CardDetail()
    
    static var Card_ID:Int              = 0
    static var Card_Name:String         = ""
    static var Card_Number:String       = ""
    
}




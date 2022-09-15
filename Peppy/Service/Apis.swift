//
//  Apis.swift
//  Youtubely
//
//  Created by iMac on 06/07/21.
//

import Foundation

class Apis: NSObject{
    static let sharedInstanse = Apis()
    
    let YOUTUBE_API_KEY = "AIzaSyBL7ACkcE2iBnH8zgBTZNzOyrPtmEEuTnQ"
    let YOUTUBE_CHANNEL_ID = "UCBJycsmduvYEL83R_U4JriQ"
    let YOUTUBE_PER_PAGE = 10
    let BASE_URL = "https://www.googleapis.com/youtube/v3/"
    let SEARCH = "search?"
    let VIDEO = "videos?"
    let ORDER = "&order=date"
    let PART = "&part=snippet"
    let ORDER_MOST_VIEWED = "&order=viewCount"
    let PART_DETAIL = "&part=snippet,statistics"
    let NEXT_PAGE_TOKEN = "&pageToken="
    
}

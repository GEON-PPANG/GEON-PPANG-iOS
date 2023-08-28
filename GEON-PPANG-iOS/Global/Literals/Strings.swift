//
//  Strings.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/01.
//

import Foundation

struct I18N {
    
    /// Home
    struct Home {
        static let searchPlaceholder = "궁금한 건빵집을 입력해주세요!"
        static let bottomSectionTitle =
            """
            건빵은 건강한 빵집의 위치와 성분 정보를 제공하여 소비자의 선택을 돕는 용도의 서비스입니다. 건빵의 모든 정보는 제조사에서 제공한 정보입니다. 이는 소비자의 구매를 돕기 위한 참고 사항이며, 제공 정보의 오류에 대한 책임을 지지 않습니다.
            """
    }
    
    /// Onboarding
    struct Onboarding {
        static let latelySigninText = "최근에 카카오톡으로 로그인 했습니다."
        static let latelySigninSNS = "카카오톡"
        static let emailSignIn = "이메일로 로그인"
        static let emailSignUp = "이메일로 회원가입"
    }
    
    /// Bottomsheet
    struct Bottomsheet {
        static let email = "사용 가능한 이메일입니다."
        static let diableNickname = "사용 가능한 닉네임입니다."
        static let checkIdPassword = "아이디 및 비밀번호를\n확인해주세요"
        
    }
    
    /// WriteReviewViewController
    struct WriteReview {
        static let writeReview = "리뷰 쓰기"
        static let likeOptionTitle = "건빵집은 어떠셨나요?"
        static let likePlaceholder = "추가로 좋았던 점이 있다면 말씀해주세요!"
        static let dislikePlaceholder = "자유롭게 의견을 말씀해주세요!"
        static let like = "좋아요"
        static let dislike = "별로예요"
        static let optionTitle = "어떤것을 추천하나요?"
        static let aboutReview = "솔직하게 작성해주신 리뷰는 건빵 소비자에게 도움이 됩니다! 하지만 선량한 업주나 제3자의 권리를 침해하는 게시물 (허위 리뷰, 명예훼손, 욕설, 타인 비방글 등)은 안내 없이 삭제되며, 관련법률에 따라 제재를 받을 수 있습니다. 또한, 건빵은 이에 대한 책임을 지지 않습니다."
        static let sheetTitle = "정말 리뷰 작성을 그만하실 건가요?"
        static let sheetDescription = "여러분이 작성해주신 리뷰가\n다른 유저의 건빵생활을 도울 수 있어요 "
        static let sheetQuit = "네, 그만 쓸게요"
        static let sheetContinue = "아니요, 계속 쓸게요"
        
        static let confirmSheetTitle = "작성이 완료됐어요!"
    }
    
    /// BakeryList
    struct BakeryList {
        static let bakeryTitle = "건빵집 리스트"
        static let glutenfree = "글루텐프리"
        static let nutfree = "넛프리"
        static let vegan = "비건빵"
        static let noSugar = "저당, 무설탕"
        static let defaultFilter = "기본순"
    }
    
    /// Filter Selection
    struct Filter {
        static let purposeTitle = "맞춤 빵집 추천을 위해\n건빵을 찾은 이유를 알려주세요!"
        static let breadTypeTitle = "어떤 빵을 원하시나요?"
        static let ingredientTitle = "어떤 성분을 원하시나요?"
        static let subtitle = "중복선택이 가능해요!"
        static let welcomeTitle = "님:)\n건빵에 오신 걸 환영해요!"
        static let skip = "건너뛰기 "
    }
    
    /// MyPage
    struct MyPage {
        static let title = "마이페이지"
        static let bookmark = "저장목록"
        static let myReviews = "내가 쓴 리뷰"
        static let terms = "이용약관"
        static let commonQuestions = "자주 묻는 질문"
        static let askQuestions = "문의하기"
        static let appVersion = "앱버전"
        static let appVersionNum = "v 0.0.1"
    }
    
    /// MySavedBakery
    struct MySavedBakery {
        static let naviTitle = "저장 목록"
    }
    
    /// MyReviews
    struct MyReviews {
        static let naviTitle = "내가 쓴 리뷰"
    }
    
    /// SortBottomSheet
    struct SortBottomSheet {
        static let sortBy = "정렬"
        static let byDefault = "기본순"
        static let byReviews = "리뷰 많은 순"
    }
    
    /// Detail
    struct Detail {
        static let writeReview = "리뷰 작성하기"
    }
    
    /// Nickname
    struct Nickname {
        static let title = "건빵에 오신걸 환영해요!\n어떻게 불러드릴까요?"
    }
}

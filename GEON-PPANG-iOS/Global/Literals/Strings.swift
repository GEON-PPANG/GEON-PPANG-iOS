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
             - 건빵은 건강한 빵집의 위치와 성분 정보를 제공하여 소비자의 선택을 돕는 용도의 서비스입니다. 건빵의 모든 정보는 제조사에서 제공한 정보입니다. 이는 소비자의 구매를 돕기 위한 참고 사항이며, 제공 정보의 오류에 대한 책임을 지지 않습니다.
            """
    }
    
    /// Onboarding
    struct Onboarding {
        static let latelySigninText = "최근에 카카오톡으로 로그인 했습니다."
        static let latelySigninSNS = "카카오톡"
    }
    
    /// WriteReviewViewController
    struct WriteReview {
        static let likeOptionTitle = "건빵집은 어떠셨나요?"
        static let likePlaceholder = "추가로 좋았던 점이 있다면 말씀해주세요!"
        static let dislikePlaceholder = "자유롭게 의견을 말씀해주세요!"
        static let like = "좋아요"
        static let dislike = "별로예요"
        static let optionTitle = "어떤것을 추천하나요?"
        static let aboutReview = """
            솔직하게 작성해주신 리뷰는 건빵 소비자에게 도움이 됩니다!
            하지만 선량한 업주나 제3자의 권리를 침해하는 게시물 (허위 리뷰,
            명예훼손, 욕설, 타인 비방글 등)은 안내 없이 삭제되며, 관련법률에 따라
            제재를 받을 수 있습니다. 또한, 건빵은 이에 대한 책임을 지지 않습니다.
        """
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
        static let purposeTitle = "반가워요 님 :)\n건빵을 찾은 이유를 알려주세요!"
        static let breadTypeTitle = "어떤 빵을 원하시나요?"
        static let breadTypeSubtitle = "중복선택이 가능해요!"
        static let ingredientTitle = "어떤 성분을 원하시나요?"
        static let ingredientSubtitle = "중복선택이 가능해요!"
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
}

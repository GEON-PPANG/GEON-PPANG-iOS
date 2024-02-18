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
        static let bubbleTitle = "맞춤 빵집을 위한 필터를 설정해 보세요!"
    }
    
    /// Search
    struct Search {
        static let searchPlaceholder = "빵집·지역·역 명을 검색해 보세요!"
    }
    /// Onboarding
    struct Onboarding {
        static let emailSignIn = "이메일로 로그인"
        static let emailSignUp = "이메일로 회원가입"
    }
    
    /// Welcome
    struct Welcome {
        static let welcomeText = "님:)\n건빵에 오신 걸 환영해요!"
    }
    
    /// Bottomsheet
    struct Bottomsheet {
        static let email = "사용 가능한 이메일입니다."
        static let nickname = "사용 가능한 닉네임입니다!"
        static let duplicatedNickname = "이미 존재하는 닉네임이에요"
        static let checkIdPassword = "아이디 및 비밀번호를\n확인해주세요"
        
    }
    
    /// ReviewViewController
    struct Review {
        static let writeReview = "리뷰 쓰기"
        static let myReview = "내가 쓴 리뷰"
        static let likeOptionTitle = "건빵집은 어떠셨나요?"
        static let likePlaceholder = "추가로 좋았던 점이 있다면 말씀해주세요!"
        static let dislikePlaceholder = "자유롭게 의견을 말씀해주세요!"
        static let like = "좋았어요"
        static let dislike = "아쉬웠어요"
        static let optionTitle = "어떤것을 추천하나요?"
        static let aboutReview = "솔직하게 작성해주신 리뷰는 건빵 소비자에게 도움이 됩니다! 하지만 선량한 업주나 제3자의 권리를 침해하는 게시물 (허위 리뷰, 명예훼손, 욕설, 타인 비방글 등)은 안내 없이 삭제되며, 관련법률에 따라 제재를 받을 수 있습니다. 또한, 건빵은 이에 대한 책임을 지지 않습니다."
        static let sheetTitle = "정말 리뷰 작성을 그만하실 건가요?"
        static let sheetDescription = "여러분이 작성해주신 리뷰가\n다른 유저의 건빵생활을 도울 수 있어요 "
        static let sheetQuit = "네, 그만 쓸게요"
        static let sheetContinue = "아니요, 계속 쓸게요"
        
        static let confirmSheetTitle = "작성이 완료됐어요!"
        
        static let emptyReviewText = "작성한 리뷰가 없어요"
    }
    
    /// BakeryList
    struct BakeryList {
        static let bakeryTitle = "건빵집 리스트"
        static let glutenfree = "글루텐프리"
        static let nutfree = "넛프리"
        static let vegan = "비건빵"
        static let subSugar = "대체당"
        static let defaultFilter = "기본순"
    }
    
    /// Filter Selection
    struct Filter {
        static let purposeTitle = "맞춤 빵집 추천을 위해\n건빵을 찾은 이유를 알려주세요!"
        static let breadTypeTitle = "어떤 빵을 원하시나요?"
        static let ingredientTitle = "원하시는 성분공개 정도를\n선택해주세요!"
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
        static let logout = "로그아웃"
        static let leave = "회원탈퇴"
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
        static let map = "지도"
        static let homepage = "웹사이트"
        static let instagram = "인스타그램"
        static let menuNotice = "가게 상세정보 및 메뉴는 업체에서 제공한 정보를 바탕으로 합니다.\n건빵집 방문 시 한 번 더 확인하시기를 권장합니다."
        static let report = "신고"
        static let reviewReport = "리뷰 신고"
        static let addBookmark = "저장되었어요!"
        static let delBookmark = "저장이 취소되었어요!"
        static let writeReview = "리뷰 작성하기"
    }
    
    /// Report
    struct Report {
        static let reportReason = "신고하려는 사유를 선택해 주세요!"
        static let advertisement = "홍보 및 신뢰할 수 없는 게시물"
        static let profanity = "욕설, 음란어, 혐오 발언 사용"
        static let defamation = "명예훼손, 저작권 침해"
        static let others = "그 외 다른 문제"
        static let detailReportReason = "자세한 신고 사유는 아래 적어주세요!"
        static let detailPlaceholder = "신고 내용을 입력해 주세요."
        static let pleaseReport = "여러분의 신고를 바탕으로 깨끗한 리뷰를 제공해 드릴 수 있도록 노력하겠습니다."
        static let reportComplete = "신고가 완료됐어요!"
    }
    
    /// Nickname
    struct Nickname {
        static let title = "건빵에 오신걸 환영해요!\n어떻게 불러드릴까요?"
    }
    
    /// SignIn
    struct SignIn {
        static let title = "회원가입을 위한 \n정보를 입력해주세요!"
    }
    
    /// Rule
    struct Rule {
        static let email = "사용 가능한 이메일입니다"
        static let disableEmail = "올바른 이메일을 입력해주세요."
        static let password = "영문, 숫자 포함 8자리 이상"
        static let nickname = "8자 이내, 특수문자 금지"
        static let checkPassword = "비밀번호를 확인해주세요"
        static let duplicatedEmail = "이미 존재하는 이메일입니다"

    }
    
    /// LogIn
    struct LogIn {
        static let title = "로그인"
        static let noAccount = "계정이 없으신가요?"
        static let signIn = "회원가입하기"
    }
    
    /// BakeryListFilter
    struct BakeryListFilter {
        static let title = "내 필터 적용"
    }
    
    struct LoginRequiredViewController {
        static let recommendation = "별사탕님 맞춤 건빵을 추천하려면\n로그인이 필요해요"
        static let profile = "별사탕님만의 페이지를 만들려면\n로그인이 필요해요"
        static let bookmark = "건빵집을 저장하려면\n로그인이 필요해요"
        static let writeReview = "리뷰를 작성하려면\n로그인이 필요해요"
        static let reportReview = "리뷰를 신고하려면\n로그인이 필요해요"
    }
}

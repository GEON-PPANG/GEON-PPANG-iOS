#!/bin/sh

#  ci_post_clone.sh
#  GEON-PPANG-iOS
#
#  Created by JEONGEUN KIM on 3/29/24.
#  

FOLDER_PATH="/Volumes/workspace/repository/GEON-PPANG-iOS"

# PARTS 배열의 두 번째 요소가 "Scheme Name"에 해당
IFS='-' read -ra PARTS <<< "$CI_XCODE_SCHEME"

# *.xconfig 파일 이름
CONFIG_FILENAME="${PARTS[1]}.xcconfig"

# *.xconfig 파일의 전체 경로 계산
CONFIG_FILE_PATH="$FOLDER_PATH/$CONFIG_FILENAME"

# 환경 변수에서 값을 가져와서 *.xconfig 파일에 추가하기
echo "BASE_URL = $BASE_URL" >> "$CONFIG_FILE_PATH"
echo "NATIVE_APP_KEY = $NATIVE_APP_KEY" >> "$CONFIG_FILE_PATH"
echo "AMPLITUDE_API_KEY = $AMPLITUDE_API_KEY" >> "$CONFIG_FILE_PATH"

# 생성된 *.xconfig 파일 내용 출력
cat "$CONFIG_FILE_PATH"

echo "${PARTS[1]}.xcconfig 파일이 성공적으로 생성되었고, 환경변수 값이 확인되었습니다.

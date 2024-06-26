#!/bin/sh

#  ci_post_clone.sh
#  GEON-PPANG-iOS
#
#  Created by JEONGEUN KIM on 5/23/24.
#  
FOLDER_PATH="/Volumes/workspace/repository/GEON-PPANG-iOS/Resource"

# *.xconfig 파일 이름
CONFIG_FILENAME="Config.xcconfig"

# *.xconfig 파일의 전체 경로 계산
CONFIG_FILE_PATH="$FOLDER_PATH/$CONFIG_FILENAME"

# 환경 변수에서 값을 가져와서 *.xconfig 파일에 추가하기
{
    echo "BASE_URL = $BASE_URL"
    echo "NATIVE_APP_KEY = $NATIVE_APP_KEY"
    echo "AMPLITUDE_API_KEY = $AMPLITUDE_API_KEY"
    
} >> "$CONFIG_FILE_PATH"

# 생성된 *.xconfig 파일 내용 출력
cat "$CONFIG_FILE_PATH"

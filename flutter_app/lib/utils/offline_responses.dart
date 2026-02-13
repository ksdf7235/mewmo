import 'dart:math';

final _random = Random();

/// 서버 연결 불가 시 로컬에서 생성하는 펫 대체 응답
String generateOfflineResponse({
  required String petName,
  required String petSound,
  required String content,
}) {
  final templates = [
    '주인님, 오늘도 고생했어 $petSound! $petName이(가) 항상 응원해 $petSound!',
    '주인님 힘들었구나... $petName이(가) 옆에 있을게 $petSound!',
    '우와~ 주인님 대단해! $petName이(가) 감동이야 $petSound!',
    '주인님 파이팅이야! $petName이(가) 믿고 있어 $petSound!',
    '그랬구나~ $petName이(가) 다 들었어 $petSound! 주인님 최고야!',
    '주인님 걱정 마! $petName이(가) 함께할게 $petSound~',
    '오늘 하루도 수고 많았어 주인님 $petSound! 푹 쉬어!',
    '주인님~ $petName이(가) 여기 있잖아 $petSound! 힘내자!',
    '주인님의 이야기 재밌다 $petSound! 더 들려줘!',
    '$petName이(가) 주인님 좋아해 $petSound! 언제나 편이야!',
  ];

  return templates[_random.nextInt(templates.length)];
}

import { ApiResponseCode } from '@/common/constants/api-response-code.enum';

export interface ApiResponse {
  code: ApiResponseCode;
  data: object;
  timestamp: string;
}

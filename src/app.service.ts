import { Injectable } from '@nestjs/common';
import { ApiResponse } from '@/common/interfaces/api-response.interface';
import * as packageJson from '@/../package.json';
import { ApiResponseCode } from '@/common/constants/api-response-code.enum';

@Injectable()
export class AppService {
  getHealth(): ApiResponse {
    return {
      code: ApiResponseCode.HEALTH_CHECK_OK,
      data: {
        version: packageJson.version,
      },
      timestamp: new Date().toISOString(),
    };
  }
}

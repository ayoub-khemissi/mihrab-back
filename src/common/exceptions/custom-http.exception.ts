import { HttpException, HttpStatus } from '@nestjs/common';
import { ApiResponse } from '@/common/interfaces/api-response.interface';
import { ApiResponseCode } from '@/common/constants/api-response-code.enum';

export class CustomHttpException extends HttpException {
  constructor(code: ApiResponseCode, status: HttpStatus, data: object = {}) {
    const response: ApiResponse = {
      code,
      data,
      timestamp: new Date().toISOString(),
    };

    super(response, status);
  }
}

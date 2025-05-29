import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
} from '@nestjs/common';
import { ApiResponse } from '@/common/interfaces/api-response.interface';
import { ApiResponseCode } from '@/common/constants/api-response-code.enum';
import { Response } from 'express';

@Catch(HttpException)
export class JwtAuthExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();

    const status = exception.getStatus();

    const apiResponse: ApiResponse = {
      code: ApiResponseCode.AUTHENTICATION_UNAUTHORIZED,
      data: {},
      timestamp: new Date().toISOString(),
    };

    response.status(status).json(apiResponse);
  }
}

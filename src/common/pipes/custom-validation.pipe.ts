import {
  Injectable,
  ArgumentMetadata,
  PipeTransform,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { validate } from 'class-validator';
import { plainToInstance } from 'class-transformer';
import { ApiResponse } from '@/common/interfaces/api-response.interface';
import { ApiResponseCode } from '@/common/constants/api-response-code.enum';

@Injectable()
export class CustomValidationPipe implements PipeTransform {
  async transform<T>(value: T, { metatype }: ArgumentMetadata): Promise<T> {
    if (!metatype || this.isPrimitive(metatype)) {
      return value;
    }

    const object = plainToInstance(metatype as new () => T, value) as object;
    const errors = await validate(object);

    if (errors.length > 0) {
      const errorMessages = errors
        .map((err) => Object.values(err.constraints || {}))
        .flat();

      const apiResponse: ApiResponse = {
        code: ApiResponseCode.VALIDATION_ERROR,
        data: { errors: errorMessages },
        timestamp: new Date().toISOString(),
      };

      throw new HttpException(apiResponse, HttpStatus.BAD_REQUEST);
    }

    return value;
  }

  private isPrimitive(metatype: unknown): boolean {
    const types = [String, Boolean, Number, Array, Object] as const;
    return (types as readonly unknown[]).includes(metatype);
  }
}

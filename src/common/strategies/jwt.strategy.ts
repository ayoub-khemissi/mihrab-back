import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { ConfigService } from '@nestjs/config';
import { JwtPayload } from '@/common/interfaces/jwt-payload.interface';
import { CustomHttpException } from '@/common/exceptions/custom-http.exception';
import { ApiResponseCode } from '@/common/constants/api-response-code.enum';
import { HttpStatus } from '@nestjs/common';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private configService: ConfigService) {
    const secret = configService.get<string>('MIHRAB_JWT_SECRET');
    if (!secret) {
      throw new CustomHttpException(
        ApiResponseCode.AUTHENTICATION_NO_JWT_SECRET,
        HttpStatus.BAD_REQUEST,
      );
    }

    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: secret,
    });
  }

  validate(payload: JwtPayload) {
    return {
      id: payload.sub,
      email: payload.email,
      role: payload.role,
    };
  }
}

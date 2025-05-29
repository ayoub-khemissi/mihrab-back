import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UserRole } from '@prisma/client';

@Injectable()
export class AuthService {
  constructor(private readonly jwtService: JwtService) {}

  login(user: { id: bigint; email: string; role: UserRole }) {
    const payload = {
      sub: user.id,
      email: user.email,
      role: user.role,
    };

    return {
      access_token: this.jwtService.sign(payload),
    };
  }
}

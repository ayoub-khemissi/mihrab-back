import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { AuthService } from '@/auth/domain/services/auth.service';
import { JwtStrategy } from '@/common/strategies/jwt.strategy';
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard';
import { RolesGuard } from '@/common/guards/role.guard';
import { JwtAuthExceptionFilter } from '@/common/exceptions/filters/jwt-auth.exception.filter';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule,
    JwtModule.register({
      secret: process.env.MIHRAB_JWT_SECRET,
      signOptions: { expiresIn: '30d' },
    }),
  ],
  providers: [
    AuthService,
    JwtStrategy,
    JwtAuthGuard,
    RolesGuard,
    JwtAuthExceptionFilter,
  ],
  exports: [JwtAuthGuard, RolesGuard],
})
export class AuthModule {}

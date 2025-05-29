import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { UserRole } from '@prisma/client';
import { ROLES_KEY } from '@/common/decorators/user-roles.decorator';
import { Request } from 'express';
import { JwtUser } from '@/common/interfaces/jwt-user.interface';

interface RequestWithUser extends Request {
  user: JwtUser;
}

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const requiredRoles = this.reflector.getAllAndOverride<UserRole[]>(
      ROLES_KEY,
      [context.getHandler(), context.getClass()],
    );

    if (!requiredRoles) {
      return true;
    }

    const { user } = context.switchToHttp().getRequest<RequestWithUser>();
    if (!user || !user.role) {
      return false;
    }

    return requiredRoles.includes(user.role);
  }
}

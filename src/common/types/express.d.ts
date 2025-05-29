import { JwtUser } from '@/common/interfaces/jwt-user.interface';

declare module 'express' {
  export interface Request {
    user: JwtUser;
  }
}

import {
  CallHandler,
  ExecutionContext,
  Injectable,
  NestInterceptor,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

type Serializable =
  | string
  | number
  | boolean
  | null
  | undefined
  | Date
  | Serializable[]
  | { [key: string]: Serializable }
  | bigint;
type Serialized<T> = T extends bigint
  ? string
  : T extends Array<infer U>
    ? Array<Serialized<U>>
    : T extends object
      ? { [K in keyof T]: Serialized<T[K]> }
      : T;

@Injectable()
export class BigIntSerializerInterceptor implements NestInterceptor {
  intercept<T = unknown>(
    context: ExecutionContext,
    next: CallHandler<T>,
  ): Observable<Serialized<T>> {
    return next
      .handle()
      .pipe(
        map(
          (data) =>
            this.serializeBigInts(data as Serializable) as Serialized<T>,
        ),
      );
  }

  private serializeBigInts<T extends Serializable>(data: T): Serialized<T> {
    if (data === null || data === undefined) {
      return data as Serialized<T>;
    }

    if (typeof data === 'bigint') {
      return data.toString() as Serialized<T>;
    }

    if (Array.isArray(data)) {
      return data.map((item) => this.serializeBigInts(item)) as Serialized<T>;
    }

    if (typeof data === 'object' && !(data instanceof Date)) {
      const result: Record<string, unknown> = {};
      Object.entries(data).forEach(([key, value]) => {
        result[key] = this.serializeBigInts(value as Serializable);
      });
      return result as Serialized<T>;
    }

    return data as Serialized<T>;
  }
}

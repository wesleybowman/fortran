subroutine bisect_right(m,a,x,hi,lo)
      implicit none
      integer m, mid
      real a(m), x
      integer, optional :: hi
      integer, optional, intent(out) :: lo


      if (lo .lt. 0) then
          write (*,*) 'Cannot have a negative value for lo'
          stop
      endif

      if(hi .eq. 0) then
          hi=m
      endif

    do while (lo .lt. hi)

      mid = (lo+hi)/2

      if (x .lt. a(mid)) then
          hi = mid
      else
          lo = mid+1
      endif

    enddo

      lo=lo-1

    return
end

subroutine bisect_left(m,a,x,hi,lo)
      implicit none
      integer m, mid
      real a(m), x
      integer, optional :: hi
      integer, optional, intent(out) :: lo


      if (lo .lt. 0) then
          write (*,*) 'Cannot have a negative value for lo'
          stop
      endif

      if(hi .eq. 0) then
          hi=m
      endif

    do while (lo .lt. hi)

      mid = (lo+hi)/2

      if (a(mid) .lt. x) then
          lo = mid+1
      else
          hi = mid
      endif

    enddo
      lo=lo-1

    return
end

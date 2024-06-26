USE [RESPONSI]
GO
/****** Object:  Trigger [dbo].[updateStok]    Script Date: 01/06/2023 09:28:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Arynda Anna Salsabiela>
-- Create date: <Kamis, 1 Juni 2023>
-- Description:	<Mengupdate nilai stok pada tabel produk ketika produk tersebut berhasil dijual 
--				dan sekaligus menampilkan pesan ketika mengalami kondisi stok dibawah stok minimum.>
-- =============================================
ALTER TRIGGER [dbo].[updateStok]
   ON  [dbo].[JUAL]
   FOR INSERT
AS 
BEGIN
	DECLARE @NoProduk INT;
	DECLARE @Jumlah INT;
	DECLARE @Stok INT;
	DECLARE @StokMin INT;

	SELECT @NoProduk = P.NoProduk, @Jumlah = J.Jumlah, @Stok = P.Stok, @StokMin = P.StokMin
	FROM PRODUK P
	INNER JOIN JUAL J ON P.NoProduk = J.NoProduk

	UPDATE PRODUK 
	SET Stok = Stok - @Jumlah
	WHERE NoProduk = @NoProduk

	IF (@Stok - @Jumlah) < @StokMin
	BEGIN
		RAISERROR ('Stok di bawah stok minimun, harap restok', 16, 1);
		ROLLBACK TRANSACTION;
		RETURN;
	END;
END
